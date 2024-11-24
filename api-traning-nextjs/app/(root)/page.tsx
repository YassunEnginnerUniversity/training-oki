import { getCookie } from '@/actions/cookies/getCookies';
import { getMyFollowingPosts } from '@/actions/post/getMyFollowingPosts';
import { getMyPosts } from '@/actions/post/getMyPosts';
import { getPostsAll } from '@/actions/post/getPostsAll';
import { getUser } from '@/actions/user/getUser';
import LoadMore from '@/components/post/LoadMore';
import PostList from '@/components/post/PostList';
import PostModal from '@/components/post/PostModal';
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"

import { loadMorePosts } from '@/utils/loadMorePost';
import React from 'react';

const page = 1

const HomePage = async () => {
  const user = await getUser();
  const cookies = await getCookie();
  const initialPostsAll = await getPostsAll(page, cookies)
  const initialMyPosts = await getMyPosts(user.id, page, cookies)
  const initialFollowingPosts = await getMyFollowingPosts(user.id, page, cookies)

  return (
    <div className="mt-10 max-w-[700px] mx-auto px-4 mb-[200px] ">
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
          <LoadMore loadMoreAction={loadMorePosts} initialPage={page} type={"all"} userId={user.id}>
            <PostList initialPosts={initialPostsAll.posts}/>
          </LoadMore>
        </TabsContent>
        <TabsContent value="mine">
          <LoadMore loadMoreAction={loadMorePosts} initialPage={page} type={"mine"} userId={user.id}>
            <PostList initialPosts={initialMyPosts.posts}/>
          </LoadMore>
        </TabsContent>
        <TabsContent value="following">
          <LoadMore loadMoreAction={loadMorePosts} initialPage={page} type={"following"} userId={user.id}>
            <PostList initialPosts={initialFollowingPosts.posts}/>
          </LoadMore>
        </TabsContent>
      </Tabs>
    </div>
  );
};

export default HomePage;
