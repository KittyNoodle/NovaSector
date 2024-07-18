import { BooleanLike } from 'common/react';

import { useBackend } from '../backend';
import { NoticeBox } from '../components';
import { Window } from '../layouts';
import { LaunchpadControl } from './LaunchpadConsole';

type Data = {
  has_pad: BooleanLike;
  pad_closed: BooleanLike;
};

export const VioletPadRemote = (props) => {
  const { data } = useBackend<Data>();
  const { has_pad } = data;

  return (
    <Window
      title="Violetspace Launchpad Remote"
      width={300}
      height={240}
      theme="abductor"
    >
      <Window.Content>
        {(!has_pad && <NoticeBox>No Launchpad Connected</NoticeBox>) || (
          <LaunchpadControl topLevel />
        )}
      </Window.Content>
    </Window>
  );
};
