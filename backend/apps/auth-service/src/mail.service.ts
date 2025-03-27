import { Injectable } from '@nestjs/common';
import * as nodemailer from 'nodemailer';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class MailService {
  private transporter;

  constructor(private configService: ConfigService) {
    this.transporter = nodemailer.createTransport({
      service: 'gmail',
      auth: {
        user: this.configService.get<string>('SMTP_USER'),
        pass: this.configService.get<string>('SMTP_PASS'),
      }
    });
  }
  

  async sendVerificationEmail(toEmail: string, verificationLink: string): Promise<void> {
    const mailOptions = {
      from: this.configService.get<string>('SMTP_USER'),
      to: toEmail,
      subject: 'Verifica tu cuenta',
      html: `
        <h1>Verificación de Email</h1>
        <p>Para verificar tu cuenta, haz clic en el siguiente enlace:</p>
        <a href="${verificationLink}">Verificar mi cuenta</a>
      `
    };
  
    try {
      await this.transporter.sendMail(mailOptions);
    } catch (error) {
      console.error('Error al enviar el correo de verificación:', error);
      throw error;
    }
  }
  

  async sendPasswordResetEmail(toEmail: string, resetLink: string): Promise<void> {
    const mailOptions = {
      from: this.configService.get<string>('SMTP_USER'),
      to: toEmail,
      subject: 'Password Reset',
      html: `
        <h1>Password Reset Request</h1>
        <p>Please click the link below to reset your password:</p>
        <a href="${resetLink}">Reset Password</a>
      `
    };
    await this.transporter.sendMail(mailOptions);
  }
}
