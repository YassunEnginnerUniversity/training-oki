import Link from 'next/link';
import { getCurrentUser } from '@/actions/user/getCurrentUser';
import LogoutButton from './LogoutButton';

const PageHeader = async () => {
  const currentUser = await getCurrentUser();

  return (
    <header className="border-b fixed top-0 left-0 w-full bg-white z-50">
      <div className="flex items-center justify-between px-8 py-7">
        <div className="">
          <h1 className="text-xl">API-Traning-Nextjs</h1>
        </div>
        <div className="flex items-center gap-6">
          {currentUser ? (
            <>
              <div>
                <Link
                  href={'/user/' + currentUser.id}
                  className="text-base hover:opacity-70"
                >
                  {currentUser.username}
                </Link>
              </div>
              <div>
                <LogoutButton />
              </div>
            </>
          ) : (
            <div>
              <Link href={'/login'} className="justify-self-end">
                ログイン
              </Link>
            </div>
          )}
        </div>
      </div>
    </header>
  );
};

export default PageHeader;
