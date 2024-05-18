CREATE TABLE IF NOT EXISTS "doctor" (
	"serial" serial PRIMARY KEY NOT NULL,
	"file_verification" uuid NOT NULL,
	"user_id" text NOT NULL,
	"speciality" text NOT NULL,
	"experience" text NOT NULL,
	"rating" integer NOT NULL
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "doctor" ADD CONSTRAINT "doctor_user_id_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
