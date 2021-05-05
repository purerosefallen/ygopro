--高速决斗技能-我也能决斗吗？
Duel.LoadScript("speed_duel_common.lua")
function c100730192.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730192.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730192.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730192)
	Duel.Recover(1-tp,2000,REASON_EFFECT)  
	local count=1
	if Duel.GetTurnPlayer()~=tp then
		count=2
	end
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c100730192.filter)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetCondition(c100730192.limcon)
	e1:SetReset(RESET_PHASE+PHASE_END,count)
	e1:SetValue(c100730192.efilter)
	Duel.RegisterEffect(e1,tp)
	e:Reset()
end
function c100730192.filter(e,c)
	return c:IsRace(RACE_FAIRY) and c:IsFaceup()
end

function c100730192.efilter(e,te)
	return not te:GetOwner():IsRace(RACE_FAIRY)
end
function c100730192.limcon(e)
	if count==2 then return Duel.GetTurnCount()==2 end
	return true
end
