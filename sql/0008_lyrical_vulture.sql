DO $$ BEGIN
 CREATE TYPE "DaysEnum" AS ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "doctors_availability" (
	"serial" serial PRIMARY KEY NOT NULL,
	"doctor_id" integer NOT NULL,
	"days" "DaysEnum",
	"start_time" text NOT NULL,
	"end_time" text NOT NULL,
	"is_available" boolean DEFAULT true
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "doctors_availability" ADD CONSTRAINT "doctors_availability_doctor_id_doctor_serial_fk" FOREIGN KEY ("doctor_id") REFERENCES "doctor"("serial") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
