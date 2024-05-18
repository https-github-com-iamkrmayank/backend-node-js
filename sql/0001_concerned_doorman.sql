DO $$ BEGIN
 CREATE TYPE "UserType" AS ENUM('admin', 'doctor', 'user');
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
ALTER TABLE "user" ADD COLUMN "user_type" "UserType";