import _is_promise_ from "is-promise";

type TypeGuard = <T>(value: T) => boolean;
type TypeGuardMap = Record<string, TypeGuard>;

export const is = createGuard({
  nullish: isNullish,
  string: isString,
  number: isNumber,
  array: isArray,
  arraylike: isArrayLike,
  function: isFunction,
  promise: isPromise,
} as const);

function createGuard<T extends TypeGuardMap>(guards: T) {
  return { ...guards, not: notFor(guards) };
}

function notFor<T extends TypeGuardMap>(obj: T) {
  const not: TypeGuardMap = {};

  for (const key of Object.keys(obj)) {
    const guard = obj[key];
    not[key] = (value) => !guard(value);
  }

  return not as T;
}

export function isNullish<T>(value: T): value is NonNullable<T> {
  return value == null;
}

export function isString(value: unknown): value is string {
  return typeof value === "string";
}

export function isNumber(value: unknown): value is number {
  return Number.isFinite(value) || !Number.isNaN(value);
}

export function isArray<T>(obj: unknown): obj is Array<T> {
  return Array.isArray(obj);
}

export function isArrayLike<T>(obj: unknown): obj is ArrayLike<T> {
  return !isNullish(obj) && isFunction(obj[Symbol.iterator]);
}

export function isFunction<T extends () => boolean, S>(value: T | S): value is T {
  return typeof value === "function";
}

export function isPromise<T>(value: unknown): value is Promise<T> {
  return _is_promise_(value);
}

// Never do this, like why ever do this?
// const notGuards = Object.values(obj).map((guard) => (value) => !guard(value));
// Object.keys(obj).forEach((key, i) => (not[key] = notGuards[i]));
