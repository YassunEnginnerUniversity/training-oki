'user server';
import { CreateComment } from '@/types/comment/type';
import { revalidatePath } from 'next/cache';
import { redirect } from 'next/navigation';

export const createComment = async (
  prevState: CreateComment,
  formData: FormData,
): Promise<CreateComment> => {
  const content = formData.get('content');
  const postId = formData.get('postId');
  const endpoint =
    process.env.NEXT_PUBLIC_API_ENDPOINT + `/api/posts/${postId}/comments`;
  const data = { content };

  const response = await fetch(endpoint, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    credentials: 'include',
    body: JSON.stringify(data),
  });

  if (!response.ok) {
    const error = await response.json();
    return error;
  }

  redirect(`/post/${postId}`);
};
