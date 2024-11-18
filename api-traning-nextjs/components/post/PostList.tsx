import { Suspense } from 'react'
import PostItem from './PostItem'
import { getPostsAll } from '@/actions/post/getPostsAll'
import { Post } from '@/types/post/types';

const CardList = async () => {
  const posts = await getPostsAll();

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

export default CardList