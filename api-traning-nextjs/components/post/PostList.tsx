import { Suspense } from 'react'
import PostItem from './PostItem'
import { getPostsAll } from '@/actions/post/getPostsAll'
import { Post } from '@/types/post/types';
import { getMyPosts } from '@/actions/post/getMyPosts';
import { getUser } from '@/actions/user/getUser';

interface PostListProps {
  type: string,
}

const PostList = async ({type}: PostListProps) => {
  let posts:Post[] = []
  const user = await getUser();

  switch (type) {
    case "all":
      posts = await getPostsAll();
      break;

    case "mine":
      posts = await getMyPosts(user.id.toString());
      break;

    case "following":
      posts = await getMyPosts(user.id.toString());
      break;
    default:
      break;
  }

  return (
    <Suspense fallback={<div className="mt-6 text-center">Loading now</div>}>
      <div className="space-y-4">
        {posts.length > 0? (
          <>
            {posts.map((post:Post, index:number) => (
              <PostItem post={post} key={index}/>
            ))}
          </>
        ): (
          <p className="text-center mt-4">投稿がありません</p>
        )}
      </div>
    </Suspense>
  )
}

export default PostList