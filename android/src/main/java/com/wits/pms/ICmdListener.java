/*
 * This file is auto-generated.  DO NOT MODIFY.
 */
package com.wits.pms;
public interface ICmdListener extends android.os.IInterface
{
  /** Default implementation for ICmdListener. */
  public static class Default implements com.wits.pms.ICmdListener
  {
    @Override public boolean handleCommand(java.lang.String str) throws android.os.RemoteException
    {
      return false;
    }
    @Override public void updateStatusInfo(java.lang.String str) throws android.os.RemoteException
    {
    }
    @Override
    public android.os.IBinder asBinder() {
      return null;
    }
  }
  /** Local-side IPC implementation stub class. */
  public static abstract class Stub extends android.os.Binder implements com.wits.pms.ICmdListener
  {
    private static final java.lang.String DESCRIPTOR = "com.wits.pms.ICmdListener";
    /** Construct the stub at attach it to the interface. */
    public Stub()
    {
      this.attachInterface(this, DESCRIPTOR);
    }
    /**
     * Cast an IBinder object into an com.wits.pms.ICmdListener interface,
     * generating a proxy if needed.
     */
    public static com.wits.pms.ICmdListener asInterface(android.os.IBinder obj)
    {
      if ((obj==null)) {
        return null;
      }
      android.os.IInterface iin = obj.queryLocalInterface(DESCRIPTOR);
      if (((iin!=null)&&(iin instanceof com.wits.pms.ICmdListener))) {
        return ((com.wits.pms.ICmdListener)iin);
      }
      return new com.wits.pms.ICmdListener.Stub.Proxy(obj);
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
        case TRANSACTION_handleCommand:
        {
          data.enforceInterface(descriptor);
          java.lang.String _arg0;
          _arg0 = data.readString();
          boolean _result = this.handleCommand(_arg0);
          reply.writeNoException();
          reply.writeInt(((_result)?(1):(0)));
          return true;
        }
        case TRANSACTION_updateStatusInfo:
        {
          data.enforceInterface(descriptor);
          java.lang.String _arg0;
          _arg0 = data.readString();
          this.updateStatusInfo(_arg0);
          reply.writeNoException();
          return true;
        }
        default:
        {
          return super.onTransact(code, data, reply, flags);
        }
      }
    }
    private static class Proxy implements com.wits.pms.ICmdListener
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
      @Override public boolean handleCommand(java.lang.String str) throws android.os.RemoteException
      {
        android.os.Parcel _data = android.os.Parcel.obtain();
        android.os.Parcel _reply = android.os.Parcel.obtain();
        boolean _result;
        try {
          _data.writeInterfaceToken(DESCRIPTOR);
          _data.writeString(str);
          boolean _status = mRemote.transact(Stub.TRANSACTION_handleCommand, _data, _reply, 0);
          if (!_status && getDefaultImpl() != null) {
            return getDefaultImpl().handleCommand(str);
          }
          _reply.readException();
          _result = (0!=_reply.readInt());
        }
        finally {
          _reply.recycle();
          _data.recycle();
        }
        return _result;
      }
      @Override public void updateStatusInfo(java.lang.String str) throws android.os.RemoteException
      {
        android.os.Parcel _data = android.os.Parcel.obtain();
        android.os.Parcel _reply = android.os.Parcel.obtain();
        try {
          _data.writeInterfaceToken(DESCRIPTOR);
          _data.writeString(str);
          boolean _status = mRemote.transact(Stub.TRANSACTION_updateStatusInfo, _data, _reply, 0);
          if (!_status && getDefaultImpl() != null) {
            getDefaultImpl().updateStatusInfo(str);
            return;
          }
          _reply.readException();
        }
        finally {
          _reply.recycle();
          _data.recycle();
        }
      }
      public static com.wits.pms.ICmdListener sDefaultImpl;
    }
    static final int TRANSACTION_handleCommand = (android.os.IBinder.FIRST_CALL_TRANSACTION + 0);
    static final int TRANSACTION_updateStatusInfo = (android.os.IBinder.FIRST_CALL_TRANSACTION + 1);
    public static boolean setDefaultImpl(com.wits.pms.ICmdListener impl) {
      if (Stub.Proxy.sDefaultImpl == null && impl != null) {
        Stub.Proxy.sDefaultImpl = impl;
        return true;
      }
      return false;
    }
    public static com.wits.pms.ICmdListener getDefaultImpl() {
      return Stub.Proxy.sDefaultImpl;
    }
  }
  public boolean handleCommand(java.lang.String str) throws android.os.RemoteException;
  public void updateStatusInfo(java.lang.String str) throws android.os.RemoteException;
}
