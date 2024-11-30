'use client';

import PostItem from './PostItem';
import { Post } from '@/types/post/types';

interface PostListProps {
  posts: Post[];
}

const PostList = ({ posts }: PostListProps) => {
  return (
    <div className="space-y-4">
      {posts.length > 0 && (
        <>
          {posts.map((post: Post, index: number) => (
            <PostItem post={post} key={index} />
          ))}
        </>
      )}
    </div>
  );
};

export default PostList;
