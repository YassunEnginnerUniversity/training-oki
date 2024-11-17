import { Suspense } from 'react'
import PostItem from './PostItem'
import { getPostsAll } from '@/actions/post/getPostsAll'
import { Post } from '@/types/post/types';

const CardList = async () => {
  const posts = await getPostsAll();
  console.log(posts);

  return (
    <Suspense fallback={<div className="mt-6 text-center">読込中です。</div>}>
      <div className="space-y-4">
        {posts.map((post:Post, index:number) => (
          <PostItem post={post} key={index}/>
        ))}
      </div>
    </Suspense>
  )
}

export default CardList