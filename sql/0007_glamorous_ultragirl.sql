ALTER TYPE "UserType" ADD VALUE 'patient';--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "patient_reports" (
	"serial" serial PRIMARY KEY NOT NULL,
	"user_id" text NOT NULL,
	"report" text NOT NULL,
	"date" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "patient" (
	"serial" serial PRIMARY KEY NOT NULL,
	"user_id" text NOT NULL,
	"age" integer NOT NULL,
	"previous_diseases" text NOT NULL
);
--> statement-breakpoint
ALTER TABLE "doctor" ALTER COLUMN "file_verification" SET DATA TYPE text;--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "patient_reports" ADD CONSTRAINT "patient_reports_user_id_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "patient" ADD CONSTRAINT "patient_user_id_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
