import { BooleanLike } from 'common/react';

import { useBackend } from '../backend';
import {
  Box,
  Button,
  LabeledList,
  NoticeBox,
  ProgressBar,
  Section,
} from '../components';
import { Window } from '../layouts';

type Info = {
  melted: BooleanLike;
  active: BooleanLike;
  connected: BooleanLike;
  power_available: BooleanLike;
  heat: number;
  integrity: number;
  power_generated: number | string; // idk what this is, u fix it, ur a big girl u understand typing
};

export const SRFPG = (props) => {
  const {
    act,
    data: {
      melted,
      active,
      connected,
      power_available,
      heat,
      integrity,
      power_generated,
    },
  } = useBackend<Info>();
  return (
    <Window width={450} height={340}>
      <Window.Content scrollable>
        {!!melted && <NoticeBox>Reactor Integrity Compromised.</NoticeBox>}
        <Section title="Status">
          <LabeledList>
            <LabeledList.Item label="Power switch">
              <Button
                icon={active ? 'power-off' : 'times'}
                onClick={() => act('toggle_power')}
                disabled={melted}
              >
                {active ? 'On' : 'Off'}
              </Button>
            </LabeledList.Item>
            <LabeledList.Item label="Reactor Integrity">
              <ProgressBar
                value={integrity / 100}
                ranges={{
                  blue: [0.65, Infinity],
                  violet: [0.6, 0.65],
                  purple: [0.4, 0.6],
                  pink: [0.05, 0.4],
                  bad: [-Infinity, 0.05],
                }}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Internal Heat">
              <ProgressBar
                value={heat / 100}
                ranges={{
                  pink: [0.95, Infinity],
                  red: [0.65, 0.95],
                  average: [0.55, 0.65],
                  olive: [0.4001, 0.55],
                  green: [0.2, 0.4001],
                  teal: [0.1, 0.2],
                  blue: [-Infinity, 0.1],
                }}
              />
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Output">
          <LabeledList>
            <LabeledList.Item label="Current output">
              {power_generated}
            </LabeledList.Item>
            <LabeledList.Item label="Power available">
              <Box inline color={!connected && 'bad'}>
                {connected ? power_available : 'Unconnected'}
              </Box>
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
