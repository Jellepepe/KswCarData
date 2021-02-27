/*
 * This file is auto-generated.  DO NOT MODIFY.
 */
package com.wits.pms;
public interface IContentObserver extends android.os.IInterface
{
  /** Default implementation for IContentObserver. */
  public static class Default implements com.wits.pms.IContentObserver
  {
    @Override public void onChange() throws android.os.RemoteException
    {
    }
    @Override
    public android.os.IBinder asBinder() {
      return null;
    }
  }
  /** Local-side IPC implementation stub class. */
  public static abstract class Stub extends android.os.Binder implements com.wits.pms.IContentObserver
  {
    private static final java.lang.String DESCRIPTOR = "com.wits.pms.IContentObserver";
    /** Construct the stub at attach it to the interface. */
    public Stub()
    {
      this.attachInterface(this, DESCRIPTOR);
    }
    /**
     * Cast an IBinder object into an com.wits.pms.IContentObserver interface,
     * generating a proxy if needed.
     */
    public static com.wits.pms.IContentObserver asInterface(android.os.IBinder obj)
    {
      if ((obj==null)) {
        return null;
      }
      android.os.IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
      if (((iin!=null)&&(iin instanceof com.wits.pms.IContentObserver))) {
        return ((com.wits.pms.IContentObserver)iin);
      }
      return new com.wits.pms.IContentObserver.Stub.Proxy(obj);
    }
    @Override public android.os.IBinder asBinder()
    {
      return this;
    }
    @Override public boolean onTransact(int code, android.os.Parcel data, android.os.Parcel reply, int flags) throws android.os.RemoteException
    {
      java.lang.String descriptor = DESCRIPTOR;
      switch (code)
      {
        case INTERFACE_TRANSACTION:
        {
          reply.writeString(descriptor);
          return true;
        }
        case TRANSACTION_onChange:
        {
          data.enforceInterface(descriptor);
          this.onChange();
          reply.writeNoException();
          return true;
        }
        default:
        {
          return super.onTransact(code, data, reply, flags);
        }
      }
    }
    private static class Proxy implements com.wits.pms.IContentObserver
    {
      private android.os.IBinder mRemote;
      Proxy(android.os.IBinder remote)
      {
        mRemote = remote;
      }
      @Override public android.os.IBinder asBinder()
      {
        return mRemote;
      }
      public java.lang.String getInterfaceDescriptor()
      {
        return DESCRIPTOR;
      }
      @Override public void onChange() throws android.os.RemoteException
      {
        android.os.Parcel _data = android.os.Parcel.obtain();
        android.os.Parcel _reply = android.os.Parcel.obtain();
        try {
          _data.writeInterfaceToken(DESCRIPTOR);
          boolean _status = mRemote.transact(Stub.TRANSACTION_onChange, _data, _reply, 0);
          if (!_status && getDefaultImpl() != null) {
            getDefaultImpl().onChange();
            return;
          }
          _reply.readException();
        }
        finally {
          _reply.recycle();
          _data.recycle();
        }
      }
      public static com.wits.pms.IContentObserver sDefaultImpl;
    }
    static final int TRANSACTION_onChange = (android.os.IBinder.FIRST_CALL_TRANSACTION + 0);
    public static boolean setDefaultImpl(com.wits.pms.IContentObserver impl) {
      if (Stub.Proxy.sDefaultImpl == null && impl != null) {
        Stub.Proxy.sDefaultImpl = impl;
        return true;
      }
      return false;
    }
    public static com.wits.pms.IContentObserver getDefaultImpl() {
      return Stub.Proxy.sDefaultImpl;
    }
  }
  public void onChange() throws android.os.RemoteException;
}
