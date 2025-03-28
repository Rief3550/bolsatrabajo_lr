import { Entity, PrimaryGeneratedColumn, Column, OneToMany } from 'typeorm';
import { UserServiceEntity } from './userService.entity';

@Entity('users')
export class User {
  @PrimaryGeneratedColumn({ name: 'user_id' })
  userId!: number;

  @Column({ unique: true })
  username!: string;

  // ... otros campos ...

  // Aquí es donde declaramos la relación 1 -> N
  @OneToMany(() => UserServiceEntity, us => us.user)
  userServices!: UserServiceEntity[];
}
