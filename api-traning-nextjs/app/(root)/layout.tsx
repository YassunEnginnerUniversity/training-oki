import type { Metadata } from 'next';
import { Noto_Sans_JP } from 'next/font/google';
import '../globals.css';
import PageHeader from '@/components/header/PageHeader';
import { Sidebar } from '@/components/utils/Sidebar';


const noto = Noto_Sans_JP({
  weight: ['400', '700'],
  style: 'normal',
  subsets: ['latin'],
});

export const metadata: Metadata = {
  title: 'Rails API and Next.js',
  description: 'Create Rails API and Next.js',
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="ja">
      <body className={noto.className}>
        <PageHeader/>
        <main className="flex pt-[92px]">
          <Sidebar/>
          <div className="pl-64 flex-1 ">
            {children}
          </div>
        </main>
      </body>
    </html>
  );
}
