import { Entity, Column, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn } from 'typeorm';
import { ObjectType, Field } from '@nestjs/graphql';

@ObjectType()
@Entity('users')
export class User {
  @PrimaryGeneratedColumn({ name: 'user_id' })
userId!: number;

  @Column({ unique: true, length: 50 })
  username!: string;

  @Column({ name: 'password_hash', type: 'varchar', length: 255, nullable: true })
  passwordHash?: string | null;


  @Column({ name: 'first_name', length: 100, nullable: true })
  firstName?: string;

  @Column({ name: 'last_name', length: 100, nullable: true })
  lastName?: string;

  @Column({ unique: true, length: 100 })
  email!: string;

  @Column({ name: 'email_verified', type: 'tinyint', default: 0 })
  emailVerified!: boolean;

  @Column({ name: 'verification_token', length: 255, nullable: true })
  verificationToken?: string;

  @Column({ name: 'password_reset_token', length: 255, nullable: true })
  passwordResetToken?: string;

  @Column({ name: 'password_reset_expires', type: 'datetime', nullable: true })
  passwordResetExpires?: Date;

  @Column({ name: 'google_id', length: 255, nullable: true })
  googleId?: string;

  @Column({ nullable: true, length: 255 })
  domicilio?: string;

  @Column({ nullable: true })
  edad?: number;

  @Column({ name: 'persona_type', length: 20, nullable: true })
  personaType?: string;

  @Column({ name: 'is_blocked', type: 'tinyint', default: 0 })
  isBlocked!: boolean;

  @Column({ name: 'is_available', type: 'tinyint', default: 1 })
  isAvailable!: boolean;

  @Column({ name: 'profile_summary', type: 'text', nullable: true })
  profileSummary?: string;

  @Column({ name: 'accepted_confidential', type: 'tinyint', default: 0 })
  acceptedConfidential!: boolean;

  @Column({ name: 'last_login', type: 'datetime', nullable: true })
  lastLogin?: Date;

  @CreateDateColumn({ name: 'created_at' })
  createdAt!: Date;

  @UpdateDateColumn({ name: 'updated_at' })
  updatedAt!: Date;
}
