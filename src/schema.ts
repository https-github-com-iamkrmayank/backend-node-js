import {
  boolean,
  integer,
  pgEnum,
  pgTable,
  serial,
  text,
  timestamp,
  uuid,
} from "drizzle-orm/pg-core";

export const UserType = pgEnum("UserType", ["admin", "doctor", "patient"]);
export const DoctorStatus = pgEnum("DoctorStatus", ["pending", "approved"]);
export const userTable = pgTable("user", {
  id: text("id").primaryKey(),
  user_sub: text("user_sub").notNull(),
  email: text("email").notNull(),
  givenName: text("given_name"),
  familyName: text("family_name"),
  picture: text("picture").notNull(),
  createdAt: timestamp("created_at", {
    withTimezone: true,
    mode: "date",
  })
    .notNull()
    .defaultNow(),
  userType: UserType("user_type"),
});

export const sessionTable = pgTable("session", {
  id: text("id").primaryKey(),
  userId: text("user_id")
    .notNull()
    .references(() => userTable.id),
  expiresAt: timestamp("expires_at", {
    withTimezone: true,
    mode: "date",
  }).notNull(),
});

export const PatientTable = pgTable("patient", {
  Serials: serial("serial").primaryKey(),
  user_id: text("user_id")
    .notNull()
    .references(() => userTable.id),
  age: integer("age").notNull(),
  previousDiseases: text("previous_diseases").notNull(),
});

export const PatientReports = pgTable("patient_reports", {
  Serials: serial("serial").primaryKey(),
  user_id: text("user_id")
    .notNull()
    .references(() => userTable.id),
  report: text("report").notNull(),
  date: timestamp("date", {
    withTimezone: true,
    mode: "date",
  })
    .notNull()
    .defaultNow(),
});

export const DoctorTable = pgTable("doctor", {
  Serials: serial("serial").primaryKey(),
  fileVerification: text("file_verification").notNull(),
  user_id: text("user_id")
    .notNull()
    .references(() => userTable.id),
  speciality: text("speciality").notNull(),
  experience: text("experience").notNull(),
  about: text("about").notNull(),
  rating: integer("rating").notNull().default(0),
  status: DoctorStatus("status").default("pending"),
});

export const DaysEnum = pgEnum("DaysEnum", [
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
]);

export const DoctorsAvailability = pgTable("doctors_availability", {
  Serials: serial("serial").primaryKey(),
  doctor_id: text("doctor_id")
    .notNull()
    .references(() => userTable.id),
  day: DaysEnum("days"),
  startTime: text("start_time").notNull(),
  endTime: text("end_time").notNull(),
  isAvailable: boolean("is_available").default(true),
});

export const BookingTable = pgTable("booking", {
  Serials: serial("serial").primaryKey(),
  doctor_id: text("doctor_id")
    .notNull()
    .references(() => userTable.id),
  patient_id: text("patient_id")
    .notNull()
    .references(() => userTable.id),
  dateAndTime: timestamp("booked_date_time", {
    withTimezone: true,
    mode: "date",
  }).notNull(),
  // date: timestamp("date", {
  //   withTimezone: true,
  //   mode: "date",
  // }).notNull(),
  // time: text("time").notNull(),
  // status: text("status").notNull().default("pending"),
  end_report: text("end_report"),
  prescription: text("prescription"),
  rating: integer("rating"),
  review: text("review"),
  isCompleted: boolean("is_completed").default(false),
  isCancelled: boolean("is_cancelled").default(false),
  isApproved: boolean("is_approved").default(false),
  isRejected: boolean("is_rejected").default(false),
  isRescheduled: boolean("is_rescheduled").default(false),
  rescheduledDate_Time: timestamp("rescheduled_date_time", {
    withTimezone: true,
    mode: "date",
  }),
  rescheduledReason: text("rescheduled_reason"),
});
