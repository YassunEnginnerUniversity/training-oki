import { getCookie } from '@/actions/cookies/getCookies';
import { getMyFollowingPosts } from '@/actions/post/getMyFollowingPosts';
import { getMyPosts } from '@/actions/post/getMyPosts';
import { getPostsAll } from '@/actions/post/getPostsAll';
import { getCurrentUser } from '@/actions/user/getCurrentUser';
import LoadMore from '@/components/post/LoadMore';
import PostList from '@/components/post/PostList';
import PostModal from '@/components/post/PostModal';
import { Tabs, TabsContent } from '@/components/ui/tabs';

import { loadMorePosts } from '@/utils/loadMorePost';
import { redirect } from 'next/navigation';
import React from 'react';
import TabPostList from '@/components/post/TabPostList';

const page = 1;

const HomePage = async ({
  searchParams,
}: {
  searchParams: Promise<{ [key: string]: string | string[] | undefined }>;
}) => {
  const currentUser = await getCurrentUser();
  let defaultValue = 'all';
  const filters = (await searchParams).tab;

  if (!currentUser) {
    redirect('/login');
  }
  console.log(filters);

  switch (filters) {
    case 'mine':
      defaultValue = 'mine';
      break;
    case 'following':
      defaultValue = 'following';
      break;
    default:
      break;
  }

  const cookies = await getCookie();
  const initialPostsAll = await getPostsAll(page, cookies);
  const initialMyPosts = await getMyPosts(currentUser.id, page, cookies);
  const initialFollowingPosts = await getMyFollowingPosts(
    currentUser.id,
    page,
    cookies,
  );

  return (
    <div className="mt-10 max-w-[850px] mx-auto px-4 mb-[200px] w-full">
      <Tabs defaultValue={defaultValue}>
        <div className="flex justify-between">
          <TabPostList />
          <PostModal />
        </div>
        <TabsContent value="all">
          <LoadMore
            loadMoreAction={loadMorePosts}
            initialPage={page}
            type={'all'}
            userId={currentUser.id}
          >
            <PostList initialPosts={initialPostsAll.posts} />
          </LoadMore>
        </TabsContent>
        <TabsContent value="mine">
          <LoadMore
            loadMoreAction={loadMorePosts}
            initialPage={page}
            type={'mine'}
            userId={currentUser.id}
          >
            <PostList initialPosts={initialMyPosts.posts} />
          </LoadMore>
        </TabsContent>
        <TabsContent value="following">
          <LoadMore
            loadMoreAction={loadMorePosts}
            initialPage={page}
            type={'following'}
            userId={currentUser.id}
          >
            <PostList initialPosts={initialFollowingPosts.posts} />
          </LoadMore>
        </TabsContent>
      </Tabs>
    </div>
  );
};

export default HomePage;
