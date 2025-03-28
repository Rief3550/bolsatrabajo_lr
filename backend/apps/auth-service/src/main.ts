// main.ts
import { NestFactory } from '@nestjs/core';
import { AuthServiceModule } from './auth-service.module';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import * as dotenv from 'dotenv';

dotenv.config({ path: process.env.NODE_ENV === 'production' ? '.env.production' : '.env.development' });

async function bootstrap() {
  const app = await NestFactory.create(AuthServiceModule);
  const config = new DocumentBuilder()
    .setTitle('Cats example')
    .setDescription('The cats API description')
    .setVersion('1.0')
    .addTag('cats')
    .build();
  const documentFactory = () => SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api', app, documentFactory); 
  await app.listen(process.env.PORT || 3000);
}
bootstrap();