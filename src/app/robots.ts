import { MetadataRoute } from "next";

export default function robots(): MetadataRoute.Robots {
  const baseUrl = process.env.NEXTAUTH_URL || "https://banglaprompts.com";

  return {
    rules: [
      {
        userAgent: "*",
        allow: "/",
        disallow: [
          "/api/",
          "/admin/",
          "/settings/",
          "/login",
          "/register",
        ],
      },
    ],
    sitemap: `${baseUrl}/sitemap.xml`,
  };
}
