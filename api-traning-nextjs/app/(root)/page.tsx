import PostList from '@/components/post/PostList';
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import React from 'react';

const HomePage = () => {
  return (
    <div className="mt-10 max-w-[700px] mx-auto px-4">
      <Tabs defaultValue="all">
        <TabsList>
          <TabsTrigger value="all">All Posts</TabsTrigger>
          <TabsTrigger value="mine">My Posts</TabsTrigger>
          <TabsTrigger value="following">Following</TabsTrigger>
        </TabsList>
        <TabsContent value="all">
          <PostList />
        </TabsContent>
        <TabsContent value="mine">
          <PostList />
        </TabsContent>
        <TabsContent value="following">
          <PostList />
        </TabsContent>
      </Tabs>
    </div>
  );
};

export default HomePage;
