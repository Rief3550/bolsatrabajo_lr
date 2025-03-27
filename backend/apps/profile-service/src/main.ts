import { NestFactory } from '@nestjs/core';
import { ProfileServiceModule } from './profile-service.module';

async function bootstrap() {
  const app = await NestFactory.create(ProfileServiceModule);
  // Tomar el puerto de .env o usar por defecto 3000
  await app.listen(process.env.PORT || 3000);
}
bootstrap();
