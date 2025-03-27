import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from '../entities/user.entity';
import { UserProfession } from '../entities/userProfession.entity';
import { Profession } from '../entities/profession.entity';
import { ServiceEntity } from '../entities/service.entity';
import { UserServiceEntity } from '../entities/userService.entity';
import { UpdateBasicInfoDto } from '../dtos/update-basic-info.dto';

@Injectable()
export class ProfileServiceService {
  constructor(
    @InjectRepository(User)
    private readonly userRepo: Repository<User>,
    @InjectRepository(UserProfession)
    private readonly userProfRepo: Repository<UserProfession>,
    @InjectRepository(UserServiceEntity)
    private readonly userServiceRepo: Repository<UserServiceEntity>,
  ) {}

  async updateBasicInfo(userId: number, dto: UpdateBasicInfoDto) {
    const user = await this.userRepo.findOne({ where: { userId } });
    if (!user) {
      throw new Error('User not found');
    }
    user.firstName = dto.firstName;
    user.lastName = dto.lastName;
    user.domicilio = dto.domicilio;
    user.edad = dto.edad;
    user.profileSummary = dto.profileSummary;
    // etc.
    return this.userRepo.save(user);
  }

  async addUserProfessions(userId: number, profs: { professionId: number, matricula?: string, yearsExperience?: number }[]) {
    // Borrás las profesiones previas o las añadís
    for (const p of profs) {
      const record = new UserProfession();
      record.userId = userId;
      record.professionId = p.professionId;
      record.matricula = p.matricula;
      record.yearsExperience = p.yearsExperience;
      await this.userProfRepo.save(record);
    }
    return { message: 'Professions added' };
  }

  async addUserServices(userId: number, services: { serviceId: number, additionalInfo?: string }[]) {
    for (const s of services) {
      const record = new UserServiceEntity();
      record.userId = userId;
      record.serviceId = s.serviceId;
      record.additionalInfo = s.additionalInfo;
      await this.userServiceRepo.save(record);
    }
    return { message: 'Services added' };
  }
}
