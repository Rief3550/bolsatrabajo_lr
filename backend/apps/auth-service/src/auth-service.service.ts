import { Injectable, HttpException, HttpStatus } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from './entities/user.entity';
import * as bcrypt from 'bcrypt';
import * as jwt from 'jsonwebtoken';
import { MailService } from './mail.service';
import { v4 as uuidv4 } from 'uuid';

@Injectable()
export class AuthService {
  constructor(
    @InjectRepository(User)
    private readonly userRepository: Repository<User>,
    private readonly mailService: MailService,
  ) {}

  async register(email: string, password: string, username: string): Promise<string> {
    const existingUser = await this.userRepository.findOne({ where: { email } });
    
    // Si ya existe y está verificado, no permitimos re-registro
    if (existingUser && existingUser.emailVerified) {
      throw new HttpException('User already exists', HttpStatus.BAD_REQUEST);
    }
    
    const hashedPassword = await bcrypt.hash(password, 10);
    const verificationToken = uuidv4();
  
    if (existingUser && !existingUser.emailVerified) {
      // Actualizamos el registro provisional
      existingUser.username = username;
      existingUser.passwordHash = hashedPassword;
      existingUser.verificationToken = verificationToken;
      await this.userRepository.save(existingUser);
  
      const verificationLink = `${process.env.APP_URL}/auth/verify?token=${verificationToken}&email=${encodeURIComponent(email)}`;
      try {
        await this.mailService.sendVerificationEmail(email, verificationLink);
      } catch (error) {
        throw new HttpException('Could not send verification email', HttpStatus.INTERNAL_SERVER_ERROR);
      }
      return 'User already registered but not verified. Verification email resent.';
    }
  
    // Si no existe, creamos un registro nuevo provisional
    const user = this.userRepository.create({
      email,
      username,
      passwordHash: hashedPassword,
      emailVerified: false,
      verificationToken,
    });
    await this.userRepository.save(user);
  
    const verificationLink = `${process.env.APP_URL}/auth/verify?token=${verificationToken}&email=${encodeURIComponent(email)}`;
    try {
      await this.mailService.sendVerificationEmail(email, verificationLink);
    } catch (error) {
      throw new HttpException('Could not send verification email', HttpStatus.INTERNAL_SERVER_ERROR);
    }
    
    return 'User registered. Check your email to verify your account.';
  }
  
  async registerProvisional(email: string, username: string): Promise<string> {
    const existingUser = await this.userRepository.findOne({ where: { email } });
    
    // 1. Si el usuario existe y está verificado -> error
    if (existingUser && existingUser.emailVerified) {
      throw new HttpException('User already exists', HttpStatus.BAD_REQUEST);
    }
    
    // 2. Generar nuevo token
    const verificationToken = uuidv4();
    
    // 3. Si existe pero NO verificado -> actualizar token y username
    if (existingUser && !existingUser.emailVerified) {
      existingUser.username = username;
      existingUser.verificationToken = verificationToken;
      await this.userRepository.save(existingUser);
      
      const verificationLink = `${process.env.APP_URL}/auth/verify?token=${verificationToken}&email=${encodeURIComponent(email)}`;
      await this.mailService.sendVerificationEmail(email, verificationLink);
      return 'User already registered provisionally. Verification email resent.';
    }
    
    // 4. Crear un nuevo usuario provisional (sin passwordHash)
    const user = this.userRepository.create({
      email,
      username,
      passwordHash: null as string | null,
      emailVerified: false,
      verificationToken,
    });
    await this.userRepository.save(user);
    
    // 5. Enviar mail de verificación
    const verificationLink = `${process.env.APP_URL}/auth/verify?token=${verificationToken}&email=${encodeURIComponent(email)}`;
    await this.mailService.sendVerificationEmail(email, verificationLink);
    
    return 'User provisionally registered. Check your email to verify your account.';
  }
  
  async verifyEmail(email: string, token: string): Promise<string> {
    const user = await this.userRepository.findOne({ where: { email } });
    if (!user) {
      throw new HttpException('User not found', HttpStatus.NOT_FOUND);
    }
    if (user.emailVerified) {
      return 'Email already verified.';
    }
    if (user.verificationToken !== token) {
      throw new HttpException('Invalid verification token', HttpStatus.BAD_REQUEST);
    }
    user.emailVerified = true;
    user.verificationToken = undefined;
    await this.userRepository.save(user);
    return 'Email verified successfully.';
  }
    
  async completeRegistration(email: string, password: string): Promise<string> {
    const user = await this.userRepository.findOne({ where: { email } });
    if (!user) {
      throw new HttpException('User not found', HttpStatus.NOT_FOUND);
    }
    if (!user.emailVerified) {
      throw new HttpException('Email not verified yet', HttpStatus.FORBIDDEN);
    }
    if (user.passwordHash) {
      throw new HttpException('Registration is already complete', HttpStatus.BAD_REQUEST);
    }
  
    // Seteamos la contraseña
    const hashedPassword = await bcrypt.hash(password, 10);
    user.passwordHash = hashedPassword;
    await this.userRepository.save(user);
  
    return 'Registration complete. You can now log in.';
  }
  
  
  async login(email: string, password: string): Promise<string> {
    const user = await this.userRepository.findOne({ where: { email } });
    if (!user) {
      throw new HttpException('User not found', HttpStatus.UNAUTHORIZED);
    }
    if (!user.emailVerified) {
      throw new HttpException('Email not verified', HttpStatus.FORBIDDEN);
    }
    if (!user.passwordHash) {
      throw new HttpException('Password hash is missing', HttpStatus.INTERNAL_SERVER_ERROR);
    }
    const isMatch = await bcrypt.compare(password, user.passwordHash);
    if (!isMatch) {
      throw new HttpException('Invalid credentials', HttpStatus.UNAUTHORIZED);
    }
    const payload = { id: user.id, email: user.email };
    const secret = process.env.JWT_SECRET || 'defaultSecret';
    const token = jwt.sign(payload, secret, { expiresIn: '1h' });
    return token;
  }
  
  async requestPasswordReset(email: string): Promise<string> {
    const user = await this.userRepository.findOne({ where: { email } });
    if (!user) {
      throw new HttpException('User not found', HttpStatus.NOT_FOUND);
    }
    const resetToken = uuidv4();
    const expiration = new Date();
    expiration.setHours(expiration.getHours() + 1);
    
    user.passwordResetToken = resetToken;
    user.passwordResetExpires = expiration;
    await this.userRepository.save(user);
    
    const resetLink = `${process.env.APP_URL}/auth/reset-password?token=${resetToken}&email=${encodeURIComponent(email)}`;
    await this.mailService.sendPasswordResetEmail(email, resetLink);
    return 'Password reset email sent.';
  }
  
  async resetPassword(email: string, token: string, newPassword: string): Promise<string> {
    const user = await this.userRepository.findOne({ where: { email } });
    if (!user) {
      throw new HttpException('User not found', HttpStatus.NOT_FOUND);
    }
    if (user.passwordResetToken !== token) {
      throw new HttpException('Invalid reset token', HttpStatus.BAD_REQUEST);
    }
    if (!user.passwordResetExpires || new Date() > user.passwordResetExpires) {
      throw new HttpException('Reset token expired', HttpStatus.BAD_REQUEST);
    }
    const hashedPassword = await bcrypt.hash(newPassword, 10);
    user.passwordHash = hashedPassword;
    user.passwordResetToken = undefined; // En lugar de null
    user.passwordResetExpires = undefined; // En lugar de null
    await this.userRepository.save(user);
    return 'Password has been reset successfully.';
  }

  
    
}