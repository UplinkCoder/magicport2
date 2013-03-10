
// c library

public import core.stdc.stdarg;
public import core.stdc.stdio;
public import core.stdc.stdlib;
import core.stdc.string : strcmp, strlen, strncmp, strchr, memcmp, memset, memmove, strdup, strcpy, strcat, xmemcmp = memcmp;
public import core.stdc.ctype;
public import core.stdc.errno;
public import core.stdc.limits;
public import core.sys.windows.windows;
public import core.stdc.math;
public import core.stdc.time;
public import core.stdc.stdint;
public import core.stdc.float_;

// generated source

import dmd;

// win32

alias GetModuleFileNameA GetModuleFileName;
alias CreateFileA CreateFile;
alias CreateFileMappingA CreateFileMapping;
alias WIN32_FIND_DATA WIN32_FIND_DATAA;
extern(Windows) DWORD GetFullPathNameA(LPCTSTR lpFileName, DWORD nBufferLength, LPTSTR lpBuffer, LPTSTR *lpFilePart);
alias GetFullPathNameA GetFullPathName;

// c lib

// So we can accept string literals
int memcmp(const char* a, const char* b, size_t len) { return .xmemcmp(a, b, len); }
int memcmp(void*, void*, size_t len) { assert(0); }
extern(C) const(char)* __locale_decpoint;

// Not defined for some reason
extern(C) int stricmp(const char*, const char*);
extern(C) int putenv(const char*);
extern(C) int spawnlp(int, const char*, const char*, const char*, const char*);
extern(C) int spawnl(int, const char*, const char*, const char*, const char*);
extern(C) int spawnv(int, const char*, const char**);
extern(C) int mkdir(const char*);
alias mkdir _mkdir;
extern(C) int memicmp(const char*, const char*, size_t);
extern(C) char* strupr(const char*);
extern(C) ushort _rotl(ushort, int);
extern(C) ushort _rotr(ushort, int);

int ld_sprint(const char*, ...) { assert(0); }

extern extern(C) uint _xi_a;
extern extern(C) uint _end;

// root.Object

class _Object
{
    int dyncast() { assert(0); }
    int equals(_Object) { assert(0); }
    int compare(_Object) { assert(0); }
    char *toChars() { assert(0); }
    void print()
    {
        printf("%s %p\n", toChars(), this);
    }
}

// root.Array

struct ArrayBase(U)
{
    static if (!is(U == class))
        alias U* T;
    else
        alias U T;

public:
    size_t dim;
    void** data;

private:
    size_t allocdim;

public:
    void push(size_t line = __LINE__)(T ptr)
    {
        static if (is(T == Dsymbol) && 0)
        {
            printf("from %d\n", line);
            printf("pushing 0x%.8X\n", ptr);
            printf("%s\n", ptr.kind());
            if (ptr.ident)
            {
                printf("ident 0x%.8X\n", ptr.ident);
                printf("ident %.*s\n", ptr.ident.len, ptr.ident.toChars());
            }
        }
        reserve(1);
        data[dim++] = cast(void*)ptr;
    }
    void append(typeof(this)* a)
    {
        insert(dim, a);
    }
    void reserve(size_t nentries)
    {
        //printf("Array::reserve: dim = %d, allocdim = %d, nentries = %d\n", (int)dim, (int)allocdim, (int)nentries);
        if (allocdim - dim < nentries)
        {
            if (allocdim == 0)
            {   // Not properly initialized, someone memset it to zero
                allocdim = nentries;
                data = cast(void **)mem.malloc(allocdim * (*data).sizeof);
            }
            else
            {   allocdim = dim + nentries;
                data = cast(void **)mem.realloc(data, allocdim * (*data).sizeof);
            }
        }
    }
    void remove(size_t) { assert(0); }
    void insert(size_t index, typeof(this)* a)
    {
        if (a)
        {
            size_t d = a.dim;
            reserve(d);
            if (dim != index)
                memmove(data + index + d, data + index, (dim - index) * (*data).sizeof);
            memcpy(data + index, a.data, d * (*data).sizeof);
            dim += d;
        }
    }
    void insert(size_t, T) { assert(0); }
    void setDim(size_t newdim)
    {
        if (dim < newdim)
        {
            reserve(newdim - dim);
        }
        dim = newdim;
    }
    ref T opIndex(size_t i)
    {
        return tdata()[i];
    }
    T* tdata()
    {
        return cast(T*)data;
    }
    typeof(this)* copy()
    {
        auto a = new typeof(this)();
        a.setDim(dim);
        memcpy(a.data, data, dim * (void *).sizeof);
        return a;
    }
    void shift(T ptr)
    {
        reserve(1);
        memmove(data + 1, data, dim * (*data).sizeof);
        data[0] = cast(void*)ptr;
        dim++;
    }
    void zero() { assert(0); }
    void pop() { assert(0); }
    int apply(apply_fp_t, void*) { assert(0); }
};

// root.rmem

struct mem
{
    import core.memory;
    static char* strdup(const char *p)
    {
        return p[0..strlen(p)+1].dup.ptr;
    }
    static void free(void *p) {}
    static void mark(void *pointer) {}
    static void* malloc(size_t n) { return GC.malloc(n); }
    static void* calloc(size_t size, size_t n) { return GC.calloc(size, n); }
    static void* realloc(void *p, size_t size) { return GC.realloc(p, size); }
    static void _init() {}
    static void setStackBottom(void *bottom) {}
    static void addroots(char* pStart, char* pEnd) {}
}

// root.response

int response_expand(size_t*, const(char)***)
{
    return 0;
}

// root.man

void browse(const char*) { assert(0); }

// root.port

struct Port
{
    static bool isNan(double r) { return !(r == r); }
    static real fmodl(real a, real b) { return a % b; }
    enum nan = double.nan;
    static int memicmp(const char* s1, const char* s2, size_t n) { return .memicmp(s1, s2, n); }
    static char* strupr(const char* s) { return .strupr(s); }
    enum ldbl_max = real.max;
    enum infinity = double.infinity;
}

// IntRange

struct SignExtendedNumber
{
    ulong value;
    bool negative;
    SignExtendedNumber opNeg() { assert(0); }
    SignExtendedNumber opAdd(SignExtendedNumber) { assert(0); }
    SignExtendedNumber opSub(SignExtendedNumber) { assert(0); }
    SignExtendedNumber opMul(SignExtendedNumber) { assert(0); }
    SignExtendedNumber opDiv(SignExtendedNumber) { assert(0); }
    ref SignExtendedNumber opAddAssign(ulong) { assert(0); }
    int opCmp(SignExtendedNumber) { assert(0); }
    SignExtendedNumber opShl(SignExtendedNumber) { assert(0); }
    SignExtendedNumber opShr(SignExtendedNumber) { assert(0); }
}

struct IntRange
{
    SignExtendedNumber imin, imax;
    this(dinteger_t) { assert(0); }
    this(SignExtendedNumber, SignExtendedNumber) { assert(0); }
    static IntRange fromType(Type, bool = false) { assert(0); }
    bool contains(IntRange) { assert(0); }
    IntRange _cast(Type) { assert(0); }
    static IntRange fromNumbers4(SignExtendedNumber*) { assert(0); }
    bool containsZero() { assert(0); }
    IntRange absNeg() { assert(0); }
    IntRange castUnsigned(Type) { assert(0); }
    IntRange splitBySign(IntRange, bool, IntRange, bool) { assert(0); }
    IntRange unionOrAssign(IntRange, bool) { assert(0); }
}

// Preprocessor symbols (sometimes used as values)

enum TARGET_LINUX = 0;
enum TARGET_OSX = 0;
enum TARGET_FREEBSD = 0;
enum TARGET_OPENBSD = 0;
enum TARGET_SOLARIS = 0;
enum TARGET_WINDOS = 1;

enum I64 = false;

enum _WIN32 = 1;
enum linux = false;
enum __APPLE__ = false;
enum __FreeBSD__ = false;
enum __OpenBSD__ = false;
enum __sun = false;

// complex_t

real creall(creal x) { return x.re; }
real cimagl(creal x) { return x.im; }

// longdouble.h

real ldouble(T)(T x) { return cast(real)x; }

// Backend

struct Symbol;
struct TYPE;
struct elem;
struct code;
struct block;
struct dt_t;
struct IRState;

// Util

void util_progress() { assert(0); }
int binary(char *, const(char)**, size_t) { assert(0); }

struct AA;
_Object _aaGetRvalue(AA* aa, _Object o)
{
    tracein("_aaGetRvalue");
    scope(success) traceout("_aaGetRvalue");
    scope(failure) traceerr("_aaGetRvalue");
    auto x = *cast(_Object[void*]*)&aa;
    auto k = cast(void*)o;
    if (auto p = k in x)
        return *p;
    return null;
}
_Object* _aaGet(AA** aa, _Object o)
{
    tracein("_aaGet");
    scope(success) traceout("_aaGet");
    scope(failure) traceerr("_aaGet");
    auto x = *cast(_Object[void*]**)&aa;
    auto k = cast(void*)o;
    if (auto p = k in *x)
        return p;
    else
        (*x)[k] = null;
    return k in *x;
}

struct String
{
    static size_t calcHash(const char*) { assert(0); }
}

// root.speller

void* speller(const char*, void* function(void*, const(char)*), Scope, const char*) { assert(0); }
void* speller(const char*, void* function(void*, const(char)*), Dsymbol, const char*) { assert(0); }

const(char)* idchars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_";

// root.stringtable

struct StringValue
{
    void *ptrvalue;

private:
    const(char)[] value;

public:
    size_t len() const { return value.length; }
    const(char)* toDchars() const { return value.ptr; }
};

struct StringTable
{
private:
    StringValue*[const(char)[]] table;

public:
    void _init(size_t size = 37)
    {
    }
    ~this()
    {
        table = null;
    }

    StringValue *lookup(const(char)* s, size_t len)
    {
        auto p = s[0..len] in table;
        if (p)
            return *p;
        return null;
    }
    StringValue *insert(const(char)* s, size_t len)
    {
        auto key = s[0..len];
        auto p = key in table;
        if (p)
            return null;
        key = key ~ '\0';
        return (table[key[0..$-1]] = new StringValue(null, key));
    }
    StringValue *update(const(char)* s, size_t len)
    {
        assert(len <= 1000);
        //printf("StringTable::update %d %.*s\n", len, len, s);
        auto key = s[0..len];
        auto p = key in table;
        if (p)
            return *p;
        key = key ~ '\0';
        return (table[key[0..$-1]] = new StringValue(null, key));
    }

private:
    void **search(const char *s, size_t len);
};

// hacks to support cloning classed with memcpy

static import stdstring = core.stdc.string;

template defTT(T...) { alias defTT = T; }

void* memcpy()(void* dest, const void* src, size_t size) { return stdstring.memcpy(dest, src, size); }
Type memcpy(T : Type)(ref T dest, T src, size_t size)
{
    dest = cast(T)src.clone();;
    assert(dest);
    assert(typeid(dest) == typeid(src));
    switch(typeid(src).toString())
    {
        foreach(s; defTT!("TypeBasic", "TypeIdentifier", "TypePointer", "TypeFunction", "TypeDArray", "TypeClass", "TypeStruct",
            "TypeTypeof", "TypeNull"))
        {
            case "dmd." ~ s:
                mixin("copyMembers!(" ~ s ~ ")(cast(" ~ s ~ ")dest, cast(" ~ s ~ ")src);");
                return dest;
        }
    default:
        assert(0, "Cannot copy type " ~ typeid(src).toString());
    }
    return dest;
}
T memcpy(T : Parameter)(ref T dest, T src, size_t size)
{
    dest = new Parameter(src.storageClass, src.type, src.ident, src.defaultArg);
    return dest;
}
Expression memcpy(T : Expression)(ref T dest, T src, size_t size)
{
    dest = cast(T)src.clone();;
    assert(dest);
    assert(typeid(dest) == typeid(src));
    switch(typeid(src).toString())
    {
        foreach(s; defTT!("Expression", "IntegerExp", "NullExp", "FileInitExp", "LineInitExp", "ModuleInitExp", "FuncInitExp"))
        {
            case "dmd." ~ s:
                mixin("copyMembers!(" ~ s ~ ")(cast(" ~ s ~ ")dest, cast(" ~ s ~ ")src);");
                return dest;
        }
    default:
        assert(0, "Cannot copy expression " ~ typeid(src).toString());
    }
    return dest;
}
void* memcpy(T : VarDeclaration)(ref T dest, T src, size_t size) { assert(0); }

// something is wrong with strtod/ld

double strtod(const(char)* p, char** endp)
{
    tracein("strtod");
    scope(success) traceout("strtod");
    scope(failure) traceerr("strtod");
    assert(!endp);
    import std.conv : to;
    return to!double(p[0..strlen(p)]);
}

real strtold(const(char)* p, char** endp)
{
    tracein("strtold");
    scope(success) traceout("strtold");
    scope(failure) traceerr("strtold");
    assert(!endp);
    import std.conv : to;
    return to!real(p[0..strlen(p)]);
}

void copyMembers(T : Type)(T dest, T src)
{
    static if (!is(T == _Object))
    {
        foreach(i, v; dest.tupleof)
            dest.tupleof[i] = src.tupleof[i];
        static if (!is(T == Type) && is(T U == super))
            copyMembers!(U)(dest, src);
   }
}
void copyMembers(T : _Object)(T dest, T src)
{
}

void main(string[] args)
{
    scope(success) exit(0);
    scope(failure) tracedepth = -1;

    int argc = cast(int)args.length;
    auto argv = (new const(char)*[](argc)).ptr;
    foreach(i, a; args)
        argv[i] = cast(const(char)*)(a ~ '\0').ptr;
    global = new Global();
    xmain(argc, argv);
}

int tracedepth;

//version=trace;

version(trace)
{
    void tracein(const char* s, size_t line = __LINE__)
    {
        if (tracedepth < 0)
            return;
        foreach(i; 0..tracedepth*2)
            putchar(' ');
        printf("+ %s %d\n", s, line);
        tracedepth++;
    }

    void traceout(const char* s, size_t line = __LINE__)
    {
        if (tracedepth < 0)
            return;
        tracedepth--;
        foreach(i; 0..tracedepth*2)
            putchar(' ');
        printf("- %s %d\n", s, line);
    }

    void traceerr(const char* s, size_t line = __LINE__)
    {
        if (tracedepth < 0)
            return;
        tracedepth--;
        foreach(i; 0..tracedepth*2)
            putchar(' ');
        printf("! %s %d\n", s, line);
    }
}
else
{
    void tracein(const char* s) {}
    void traceout(const char* s) {}
    void traceerr(const char* s) {}
}
