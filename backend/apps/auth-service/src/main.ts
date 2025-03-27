// main.ts
import { NestFactory } from '@nestjs/core';
import { AuthServiceModule } from './auth-service.module';
import * as dotenv from 'dotenv';

dotenv.config({ path: process.env.NODE_ENV === 'production' ? '.env.production' : '.env.development' });

async function bootstrap() {
  const app = await NestFactory.create(AuthServiceModule);
  await app.listen(process.env.PORT || 3000);
}
bootstrap();