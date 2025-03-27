import { Entity, PrimaryGeneratedColumn, Column, OneToMany } from 'typeorm';
import { UserServiceEntity } from './userService.entity';

@Entity('service')
export class ServiceEntity {
  @PrimaryGeneratedColumn({ name: 'service_id' })
  serviceId!: number;

  @Column({ type: 'varchar', length: 100 })
  name!: string;

  @OneToMany(() => UserServiceEntity, us => us.service)
  userServices!: UserServiceEntity[];
}
