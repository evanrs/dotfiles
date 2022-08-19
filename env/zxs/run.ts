#!/usr/bin/env zx

import "zx/globals";
import { is } from "./guard";

type Value<T> = T | Promise<void | T>;
type Process<T> = Value<T> | (() => Value<T>);
type Result<T, E> = { value?: Value<T> } & (
  | { status: "Loading" }
  | { status: "Failure"; error?: E }
  | { status: "Success"; value: Value<T> }
);

export function run<T, E extends unknown>(process: Process<T>) {
  const result = resultFor(process);
  const valueOf = () => Promise.resolve(result.value);

  return Object.assign(valueOf, {
    valueOf,
    get result() {
      return valueOf();
    },
    get status() {
      return result.status;
    },
    get error() {
      return result.status === "Failure" ? result.error : undefined;
    },
  });
}

export function resultFor<T, E extends unknown>(process: Process<T>) {
  let result = { status: "Loading" } as Result<T, E>;
  (async () => {
    let _ = is.function(process) ? process() : process;
    Object.assign(result, {
      status: "Success",
      value: is.promise<T>(_) ? await _ : _,
    });
  })().catch((error: E) =>
    Object.assign(result, {
      status: "Failure",
      error,
    }),
  );
  return result;
}
