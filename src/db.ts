import { neon } from "@neondatabase/serverless";
import { drizzle } from "drizzle-orm/neon-http";
import DotEnv from "dotenv";
DotEnv.config({
  path: ".env.local",
});
const sql = neon(process.env.DB_CONNECTION!);
export const db = drizzle(sql);
