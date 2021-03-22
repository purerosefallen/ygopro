--高速决斗技能-卡套上的玄机
Duel.LoadScript("speed_duel_common.lua")
function c100730182.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730182.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730182.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730182)
	local g=Duel.GetMatchingGroup(c100730182.Isdark,tp,LOCATION_DECK,0,nil)
	local tc=g:GetFirst()
	aux.SpeedDuelSendToHandWithExile(tp,tc)

	local count=1
	if Duel.GetTurnPlayer()~=tp then
		count=2
	end

	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END,count)
	e1:SetCondition(c100730182.limcon)
	e1:SetValue(c100730182.limval)
	e1:SetTargetRange(1,0)
	Duel.RegisterEffect(e1,tp,true)
	e:Reset()
end
function c100730182.limcon(e)
	if count==2 then return Duel.GetTurnCount()==2 end
	return true
end

function c100730182.limval(e,re,rp)
	return true
end

function c100730182.Isdark(c)
	return c:IsAttribute(ATTRIBUTE_DARK) and c:IsRace(RACE_SPELLCASTER) and c:IsLevelAbove(7)
end