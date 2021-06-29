--高速决斗技能-袖口藏卡
Duel.LoadScript("speed_duel_common.lua")
function c100730300.initial_effect(c)
	if not c100730300.use then
		c100730300.use={}
		c100730300.use[0]=0
		c100730300.use[1]=0
	end
	aux.SpeedDuelBeforeDraw(c,c100730300.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730300.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetCountLimit(1,100730300+100)
	e1:SetCondition(c100730300.skillcond)
	e1:SetOperation(c100730300.skillask)
	Duel.RegisterEffect(e1,tp)
	--draw count
	local e2=Effect.GlobalEffect()
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DRAW_COUNT)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetLabel(tp)
	e1:SetLabelObject(e2)
	e2:SetLabelObject(e1)
	e2:SetValue(c100730300.drval)
	Duel.RegisterEffect(e2,tp)
	local e3=Effect.GlobalEffect()
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_BATTLE_DESTROYED)
	e3:SetOperation(c100730300.reg)
	e3:SetLabelObject(e1)
	Duel.RegisterEffect(e3,tp)
end

function c100730300.reg(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabelObject() and eg:IsExists(Card.IsLevelAbove,1,nil,7) and c100730300.use[tp]~=2 then
		c100730300.use[tp]=1
	end
end

function c100730300.skillcond(e,tp,eg,ep,ev,re,r,rp)
	return c100730300.use[tp]>0
end

function c100730300.skillask(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()~=tp then return end
	if c100730300.use[tp]==1 then
		if not Duel.SelectYesNo(tp,aux.Stringid(100730300,0)) then
			c100730300.use[tp]=0
		end
		return
	elseif c100730300.use[tp]==2 then
		e:GetLabelObject():Reset()
		e:Reset()
		return
	end
end

function c100730300.drval(e)
	local tp=e:GetLabel()
	if c100730300.use[tp]==1 then
		c100730300.use[tp]=2
		return 2
	end
	return 1
end

