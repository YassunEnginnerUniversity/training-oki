import { getCookie } from '@/actions/cookies/getCookies';
import { getPostsAll } from '@/actions/post/getPostsAll';
import { getUser } from '@/actions/user/getUser';
import LoadMore from '@/components/post/LoadMore';
import PostList from '@/components/post/PostList';
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { loadMorePosts } from '@/utils/loadMorePost';
import React from 'react';

const page = 1

const HomePage = async () => {
  const user = await getUser();
  const cookies = await getCookie();
  const initialPostsAll = await getPostsAll(page, cookies)

  return (
    <div className="mt-10 max-w-[700px] mx-auto px-4 mb-[200px] ">
      <Tabs defaultValue="all">
        <TabsList>
          <TabsTrigger value="all">All Posts</TabsTrigger>
          <TabsTrigger value="mine">My Posts</TabsTrigger>
          <TabsTrigger value="following">Following</TabsTrigger>
        </TabsList>
        <TabsContent value="all">
          <LoadMore loadMoreAction={loadMorePosts} initialPage={page}>
            <PostList type={"all"} userId={user.id.toString()} initialPosts={initialPostsAll.posts}/>
          </LoadMore>
        </TabsContent>
        <TabsContent value="mine">
          {/* <PostList type={"mine"} userId={user.id.toString()}/> */}
        </TabsContent>
        <TabsContent value="following">
          {/* <PostList type={"following"} userId={user.id.toString()}/> */}
        </TabsContent>
      </Tabs>
    </div>
  );
};

export default HomePage;
