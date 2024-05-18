DO $$ BEGIN
 CREATE TYPE "DoctorStatus" AS ENUM('pending', 'approved');
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
ALTER TABLE "doctor" ADD COLUMN "status" "DoctorStatus";