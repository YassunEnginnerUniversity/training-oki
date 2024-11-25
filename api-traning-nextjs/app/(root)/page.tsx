import { getCookie } from '@/actions/cookies/getCookies';
import { getMyFollowingPosts } from '@/actions/post/getMyFollowingPosts';
import { getMyPosts } from '@/actions/post/getMyPosts';
import { getPostsAll } from '@/actions/post/getPostsAll';
import { getCurrentUser } from '@/actions/user/getCurrentUser';
import LoadMore from '@/components/post/LoadMore';
import PostList from '@/components/post/PostList';
import PostModal from '@/components/post/PostModal';
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"

import { loadMorePosts } from '@/utils/loadMorePost';
import { redirect } from 'next/navigation';
import React from 'react';

const page = 1

const HomePage = async () => {
  const currentUser = await getCurrentUser();

  if(!currentUser) {
    redirect("/login")
  }

  const cookies = await getCookie();
  const initialPostsAll = await getPostsAll(page, cookies)
  const initialMyPosts = await getMyPosts(currentUser.id, page, cookies)
  const initialFollowingPosts = await getMyFollowingPosts(currentUser.id, page, cookies)

  return (
    <div className="mt-10 max-w-[850px] mx-auto px-4 mb-[200px] w-full">
      <Tabs defaultValue="all">
        <div className="flex justify-between">
          <TabsList>
            <TabsTrigger value="all">All Posts</TabsTrigger>
            <TabsTrigger value="mine">My Posts</TabsTrigger>
            <TabsTrigger value="following">Following</TabsTrigger>
          </TabsList>
          <PostModal/>
        </div>
        <TabsContent value="all">
          <LoadMore loadMoreAction={loadMorePosts} initialPage={page} type={"all"} userId={currentUser.id}>
            <PostList initialPosts={initialPostsAll.posts}/>
          </LoadMore>
        </TabsContent>
        <TabsContent value="mine">
          <LoadMore loadMoreAction={loadMorePosts} initialPage={page} type={"mine"} userId={currentUser.id}>
            <PostList initialPosts={initialMyPosts.posts}/>
          </LoadMore>
        </TabsContent>
        <TabsContent value="following">
          <LoadMore loadMoreAction={loadMorePosts} initialPage={page} type={"following"} userId={currentUser.id}>
            <PostList initialPosts={initialFollowingPosts.posts}/>
          </LoadMore>
        </TabsContent>
      </Tabs>
    </div>
  );
};

export default HomePage;
