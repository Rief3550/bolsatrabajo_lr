// apps/auth-service/src/strategies/google.strategy.ts

import { Injectable } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { Strategy, VerifyCallback } from 'passport-google-oauth20';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from '../entities/user.entity';

@Injectable()
export class GoogleStrategy extends PassportStrategy(Strategy, 'google') {
  constructor(
    @InjectRepository(User)
    private readonly userRepository: Repository<User>,
  ) {
    super({
      clientID: process.env.GOOGLE_CLIENT_ID!,
      clientSecret: process.env.GOOGLE_CLIENT_SECRET!,
      callbackURL: process.env.GOOGLE_CALLBACK_URL!,
      scope: ['email', 'profile'],
    });
  }

  async validate(accessToken: string, refreshToken: string, profile: any, done: VerifyCallback) {
    const user = await this.findOrCreateUser(profile);
    if (!user) {
      // user = false => no login
      return done(null, false, { message: 'Cannot create or link user' });
    }
    return done(null, user);
  }

  private async findOrCreateUser(profile: any) {
    const googleId = profile.id;
    const email = profile.emails[0].value;

    // 1. Buscar user con googleId
    let user = await this.userRepository.findOne({ where: { googleId } });
    if (user) {
      return user;
    }

    // 2. No existe => buscar por email
    user = await this.userRepository.findOne({ where: { email } });
    if (!user) {
      // Crear nuevo
      user = this.userRepository.create({
        googleId,
        email,
        emailVerified: true,
        username: 'someUniqueName' // Generá un username único
        // passwordHash en blanco, etc.
      });
      await this.userRepository.save(user);
      return user;
    }

    // 3. user existe con ese email, no googleId => enlazar
    if (!user.googleId) {
      user.googleId = googleId;
      user.emailVerified = true;
      await this.userRepository.save(user);
      return user;
    }

    // 4. Caso: user.googleId ya existe => colisión => false
    return false;
  }
}
