import { Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AuthServiceController } from './auth-service.controller';
import { AuthService } from './auth-service.service';
import { MailService } from './mail.service';
import { User } from './entities/user.entity';

@Module({
  imports: [
    // Carga global de variables de entorno según NODE_ENV
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: `.env.${process.env.NODE_ENV || 'development'}`,
    }),
    // Configuración de TypeORM usando ConfigService
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      inject: [ConfigService],
      useFactory: (configService: ConfigService) => ({
        type: 'mariadb', // O 'mariadb'
        host: configService.get<string>('DB_HOST'),
        port: parseInt(configService.get<string>('DB_PORT') || '3306', 10),
        username: configService.get<string>('DB_USER'),
        password: configService.get<string>('DB_PASS'),
        database: configService.get<string>('DB_NAME'),
        entities: [User],
        // En desarrollo sincronizamos, en producción no
        synchronize: configService.get<string>('NODE_ENV') === 'development',
      }),
    }),
    // Registro de la entidad User para inyección en repositorios
    TypeOrmModule.forFeature([User]),
  ],
  controllers: [AuthServiceController],
  providers: [AuthService, MailService],
})
export class AuthServiceModule {}
