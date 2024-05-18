import { DrizzlePostgreSQLAdapter } from "@lucia-auth/adapter-drizzle";
import { Lucia } from "lucia";
import { db } from "./db";
import { UserType, sessionTable, userTable } from "./schema";
import { Google } from "arctic";
import DotEnv from "dotenv";
DotEnv.config({
  path: ".env.local",
});
const adapter = new DrizzlePostgreSQLAdapter(db, sessionTable, userTable);

export const lucia = new Lucia(adapter, {
  getUserAttributes: (UserAddtibute: DatabaseUserAttributes) => {
    return {
      Email: UserAddtibute.email,
      Firstname: UserAddtibute.givenName,
      LastName: UserAddtibute.familyName,
      Picture: UserAddtibute.picture,
      CreatedAt: UserAddtibute.createdAt,
      ProfileType: UserAddtibute.userType,
    };
  },
});

declare module "lucia" {
  interface Register {
    Lucia: typeof lucia;
    DatabaseUserAttributes: DatabaseUserAttributes;
  }
}

export const google = new Google(
  process.env.GOOGLE_CLIENT_ID!,
  process.env.GOOGLE_CLIENT_SECRET!,
  process.env.GOOGLE_REDIRECT_URI!
);

interface DatabaseUserAttributes {
  user_sub: string;
  email: string;
  givenName: string;
  familyName: string;
  picture: string;
  createdAt: Date;
  userType: "admin" | "doctor" | "user" | null;
}
