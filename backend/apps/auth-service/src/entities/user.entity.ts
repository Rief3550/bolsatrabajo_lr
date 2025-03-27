import { Entity, Column, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn } from 'typeorm';
import { ObjectType, Field } from '@nestjs/graphql';

@ObjectType()
@Entity('users')  // Asegura que la tabla se llame "users"
export class User {
  @Field()
  @PrimaryGeneratedColumn({ name: 'user_id' })  // Mapea user_id de la DB a id de la clase
  id!: number;

  @Field()
  @Column({ unique: true, type: 'varchar', nullable: false })
  username!: string;

  @Field()
  @Column({ unique: true, type: 'varchar', nullable: false })
  email!: string;

  @Column({ name: 'password_hash', type: 'varchar', nullable: true })
passwordHash?: string | null;

  @Column({ name: 'email_verified', type: 'tinyint', width: 1, default: 0 })
  emailVerified!: boolean;

  @Column({ name: 'verification_token', type: 'varchar', nullable: true })
  verificationToken?: string;

  // Campos para recovery y extras
  @Column({ name: 'password_reset_token', type: 'varchar', nullable: true })
  passwordResetToken?: string;

  @Column({ name: 'password_reset_expires', type: 'datetime', nullable: true })
  passwordResetExpires?: Date;

  @Column({ name: 'created_at', type: 'datetime', default: () => 'CURRENT_TIMESTAMP' })
  @CreateDateColumn()
  createdAt!: Date;

  @Column({ name: 'updated_at', type: 'datetime', default: () => 'CURRENT_TIMESTAMP', onUpdate: 'CURRENT_TIMESTAMP' })
  @UpdateDateColumn()
  updatedAt!: Date;
  
  // Cualquier otro campo (first_name, last_name, etc.)
}
