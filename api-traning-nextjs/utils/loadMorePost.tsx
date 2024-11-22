"use client"

import { getPostsAll } from "@/actions/post/getPostsAll"
import PostItem from "@/components/post/PostItem"
import { Post } from "@/types/post/types"

export const loadMorePosts = async (page: number) => {
  const cookies = document.cookie;
  const response = await getPostsAll(page,cookies)

  const postsAll:Post[] = response.posts // 現在のページの投稿を10件を取得
  const currentPage:number | null = response.pagenation.current_page  // 現在のページ数を取得
  const totalPage:number | null = response.pagenation.total_page  // トータルのページ数を取得

  console.log(postsAll);
  
  // 値をリテラル型にし、読み取り専用にする
  return [
    postsAll.map((post: Post) => <PostItem key={post.id} post={post}/>),
    currentPage,
    totalPage
  ] as const 
}