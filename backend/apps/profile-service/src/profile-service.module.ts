import { Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ProfileServiceController } from './profile-service.controller';
import { ProfileServiceService } from './profile-service.service';
import { User } from '../entities/user.entity';
import { Profession } from '../entities/profession.entity';
import { UserProfession } from '../entities/userProfession.entity';
import { ServiceEntity } from '../entities/service.entity';
import { UserServiceEntity } from '../entities/userService.entity';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: `.env.${process.env.NODE_ENV || 'development'}`,
    }),
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      inject: [ConfigService],
      useFactory: (configService: ConfigService) => ({
        type: 'mariadb',
        host: configService.get<string>('DB_HOST'),
        port: parseInt(configService.get<string>('DB_PORT') || '3306', 10),
        username: configService.get<string>('DB_USER'),
        password: configService.get<string>('DB_PASS'),
        database: configService.get<string>('DB_NAME'),
        entities: [
          User,
          Profession,
          ServiceEntity,
          UserProfession,
          UserServiceEntity
        ],
        synchronize: configService.get<string>('NODE_ENV') === 'development',
      }),
    }),
    TypeOrmModule.forFeature([
      User,
      Profession,
      ServiceEntity,
      UserProfession,
      UserServiceEntity
    ]),
  ],
  controllers: [ProfileServiceController],
  providers: [ProfileServiceService],
})
export class ProfileServiceModule {}
