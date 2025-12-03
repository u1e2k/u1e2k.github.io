import { defineCollection, z } from 'astro:content';

const blog = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    date: z.coerce.date(),
    categories: z.array(z.string()).optional(),
    layout: z.string().optional(),
    slug: z.string().optional(),
  }),
});

export const collections = { blog };
