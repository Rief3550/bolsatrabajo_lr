import { Test, TestingModule } from '@nestjs/testing';
import { AuthServiceController } from './auth-service.controller';
import { AuthService } from './auth-service.service';

describe('AuthServiceController', () => {
  let controller: AuthServiceController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [AuthServiceController],
      providers: [AuthService],
    }).compile();

    controller = module.get<AuthServiceController>(AuthServiceController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  it('register() should return expected message', () => {
    const result = controller.register({
        email: 'test@example.com', password: '123456',
        username: 'testuser'
    });
    expect(result).toBe('Usuario registrado. Revisa tu email para verificar tu cuenta.');
  });
});