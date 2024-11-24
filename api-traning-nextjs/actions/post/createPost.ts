"user server"
import { CreatePost } from "@/types/post/types"
import { revalidatePath } from "next/cache";
import { redirect } from 'next/navigation';

export const createPost = async (prevState: CreatePost, formData: FormData): Promise<CreatePost> => {
  const content = formData.get("content");
  const endpoint = process.env.NEXT_PUBLIC_API_ENDPOINT + '/api/posts';
  const data = { content }

  // /api/login にPOSTでデータを送る
  const response = await fetch(endpoint, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    credentials: 'include',
    body: JSON.stringify(data),
  });

  if(!response.ok) {
    const error = await response.json();

    console.log(error);
    
    return error
  }
  
  redirect("/")
}