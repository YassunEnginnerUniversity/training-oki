"use client"

import PostItem from './PostItem'
import { Post } from '@/types/post/types';

interface PostListProps {
  initialPosts: Post[]
}


const PostList = ({initialPosts}: PostListProps) => {
  return (
      <div className="space-y-4">
        {initialPosts.length > 0? (
          <>
            {initialPosts.map((post:Post, index:number) => (
              <PostItem post={post} key={index}/>
            ))}
          </>
        ): (
          <p className="text-center mt-4">投稿がありません</p>
        )}
      </div>
  )
}

export default PostList