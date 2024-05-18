ALTER TABLE "doctors_availability" DROP CONSTRAINT "doctors_availability_doctor_id_doctor_serial_fk";
--> statement-breakpoint
ALTER TABLE "doctors_availability" ALTER COLUMN "doctor_id" SET DATA TYPE text;--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "doctors_availability" ADD CONSTRAINT "doctors_availability_doctor_id_user_id_fk" FOREIGN KEY ("doctor_id") REFERENCES "user"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
