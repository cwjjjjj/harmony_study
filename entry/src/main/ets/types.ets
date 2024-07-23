export interface PoetryDataResponseType {
  id: string;
  name: string;
  type: string;
  widgetType: string;
  config: Config;
  entry: Entry;
  updateConfig: UpdateConfig;
}

export interface UpdateConfig {
  refreshDate: string;
  request: Request;
}

export interface Request {
  url: string;
  method: string;
}

export interface Entry {
  id: string;
  title: string;
  author: string;
  content: string;
  translate: string;
  notes: string[];
  appreciation: string;
  background: string;
  dynasty: string;
  quotes: string;
  expiredDate: string;
}

export interface Config {
  description: string;
  previewImg: string;
  picture: Picture;
}

export interface Picture {
  picUrl: string;
  largePicUrl: string;
  middlePicUrl: string;
  smallPicUrl: string;
  thumbnailUrl: string;
  format: string;
  width: number;
  height: number;
}