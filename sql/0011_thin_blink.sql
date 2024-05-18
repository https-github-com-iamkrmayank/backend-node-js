CREATE TABLE IF NOT EXISTS "booking" (
	"serial" serial PRIMARY KEY NOT NULL,
	"doctor_id" text NOT NULL,
	"patient_id" text NOT NULL,
	"booked_date_time" timestamp with time zone NOT NULL,
	"end_report" text,
	"prescription" text,
	"rating" integer,
	"review" text,
	"is_completed" boolean DEFAULT false,
	"is_cancelled" boolean DEFAULT false,
	"is_approved" boolean DEFAULT false,
	"is_rejected" boolean DEFAULT false,
	"is_rescheduled" boolean DEFAULT false,
	"rescheduled_date_time" timestamp with time zone,
	"rescheduled_reason" text
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "booking" ADD CONSTRAINT "booking_doctor_id_user_id_fk" FOREIGN KEY ("doctor_id") REFERENCES "user"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "booking" ADD CONSTRAINT "booking_patient_id_user_id_fk" FOREIGN KEY ("patient_id") REFERENCES "user"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
