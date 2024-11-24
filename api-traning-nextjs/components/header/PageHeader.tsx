import Link from 'next/link';
import { getUser } from '@/actions/user/getUser';
import LogoutButton from './LogoutButton';

interface PageHeaderProps {
  username: string;
}

const PageHeader = async () => {
  const user = await getUser();

  return (
    <header className="border-b fixed top-0 left-0 w-full bg-white z-50">
      <div className="flex items-center justify-between px-8 py-7">
        <div className="">
          <h1 className="text-xl">API-Traning-Nextjs</h1>
        </div>
        <div className="flex items-center gap-6">
          {user ? (
            <>
              <div>
                <Link
                  href={'/user/' + user.username.id}
                  className="text-base hover:opacity-70"
                >
                  {user.username}
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
