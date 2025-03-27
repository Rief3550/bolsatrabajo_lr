import { Controller, Get, Post, Query, Body, HttpException, HttpStatus } from '@nestjs/common';
import { AuthService } from './auth-service.service';

@Controller('auth')
export class AuthServiceController {
  constructor(private readonly authService: AuthService) {}

  @Post('register')
  async register(@Body() body: { email: string; password: string; username: string }) {
    console.log('Controller Body:', body); // <-- LOG para verificar
    const { email, password, username } = body;
    return this.authService.register(email, password, username);
  }
  @Post('register-provisional')
async registerProvisional(@Body() body: { email: string; username: string }) {
  return this.authService.registerProvisional(body.email, body.username);
}
@Get('verify')
async verifyEmail(@Query('email') email: string, @Query('token') token: string) {
  return this.authService.verifyEmail(email, token);
}


  @Post('login')
  async login(@Body() body: { email: string; password: string }): Promise<{ accessToken: string }> {
    try {
      const token = await this.authService.login(body.email, body.password);
      return { accessToken: token };
    } catch (error) {
      throw new HttpException((error as any).message || 'Login failed', HttpStatus.UNAUTHORIZED);
    }
  }
  @Post('complete-registration')
async completeRegistration(@Body() body: { email: string; password: string; confirmPassword: string }) {
  if (body.password !== body.confirmPassword) {
    throw new HttpException('Passwords do not match', HttpStatus.BAD_REQUEST);
  }
  return this.authService.completeRegistration(body.email, body.password);
}


  @Post('request-password-reset')
  async requestPasswordReset(@Body('email') email: string): Promise<string> {
    try {
      return await this.authService.requestPasswordReset(email);
    } catch (error) {
      throw new HttpException((error as any).message || 'Request password reset failed', HttpStatus.BAD_REQUEST);
    }
  }

  @Post('reset-password')
  async resetPassword(
    @Body('email') email: string,
    @Body('token') token: string,
    @Body('newPassword') newPassword: string
  ): Promise<string> {
    try {
      return await this.authService.resetPassword(email, token, newPassword);
    } catch (error) {
      throw new HttpException((error as any).message || 'Reset password failed', HttpStatus.BAD_REQUEST);
    }
  }

  @Get('test')
  testEndpoint(): string {
    return 'Endpoint de test funcionando';
  }
}