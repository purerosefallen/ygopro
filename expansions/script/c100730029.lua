--高速决斗技能-毅力
Duel.LoadScript("speed_duel_common.lua")
function c100730029.initial_effect(c)
	if not c100730029.reg then
		c100730029.reg={}
		c100730029.turn={}
		c100730029.used={}
	end
	aux.SpeedDuelBeforeDraw(c100730029.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730029.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	if Duel.GetLP(tp)>=4000 then
		c100730029.turn[tp]=Duel.GetTurnCount()
	else
		c100730029.turn[tp]=-1
	end
	if not c100730029.reg[tp] then
		c100730029.reg[tp]=true
		local e1=Effect.GlobalEffect()
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CHANGE_DAMAGE)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetTargetRange(1,0)
		e1:SetValue(c100730029.val)
		e1:SetLabel(tp)
		Duel.RegisterEffect(e1,tp,true)
	end
end

function c100730029.val(e,re,dam,r,rp,rc)
	local tp=e:GetLabel()
	if c100730029.used[tp] or c100730029.turn[tp]~=Duel.GetTurnCount() then return dam end
	if dam>=Duel.GetLP(tp) then
		c100730029.used[tp]=true
		c100730029.limit(tp)
		return Duel.GetLP(tp)-1
	end
	return dam
end

function c100730029.limit(tp)
	local count=1
	if Duel.GetTurnPlayer()~=tp then
		count=2
	end
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_COUNT_LIMIT)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_END,count)
	Duel.RegisterEffect(e1,tp,true)
end










