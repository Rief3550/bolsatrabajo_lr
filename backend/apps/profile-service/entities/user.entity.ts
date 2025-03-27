import { Entity, PrimaryGeneratedColumn, Column, OneToMany } from 'typeorm';
import { UserProfession } from './userProfession.entity';
import { UserServiceEntity } from './userService.entity';

@Entity('users')
export class User {
  @PrimaryGeneratedColumn({ name: 'user_id' })
  userId!: number;

  @Column({ unique: true })
  username!: string;

  @Column({ name: 'password_hash' })
  passwordHash!: string;

  @Column({ name: 'first_name', nullable: true })
  firstName?: string;

  @Column({ name: 'last_name', nullable: true })
  lastName?: string;

  @Column({ nullable: true })
  domicilio?: string;

  @Column({ nullable: true })
  edad?: number;

  // etc.

  @OneToMany(() => UserProfession, up => up.user)
  userProfessions!: UserProfession[];

  @Column({ name: 'profile_summary', type: 'text', nullable: true })
  profileSummary?: string; // <-- Agregás esta para que TypeORM sepa que existe
}
