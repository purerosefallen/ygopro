--高速决斗技能-假陷阱
Duel.LoadScript("speed_duel_common.lua")
function c100730037.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(66526672,c)
	if not c100730037.UsedLP then
		c100730037.UsedLP={}
		c100730037.UsedLP[0]=0
		c100730037.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelAtMainPhaseNoCountLimit(c,c100730037.skill,c100730037.con,aux.Stringid(100730037,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730037.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	if not c100730037.testCard then
		Duel.DisableActionCheck(true)
		c100730037.testCard=Duel.CreateToken(tp,65810489)
		Duel.DisableActionCheck(false)
	end
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and aux.DecreasedLP[tp]-c100730037.UsedLP[tp]>=1200
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and c100730037.testCard:IsSSetable()
end

function c100730037.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	c100730037.UsedLP[tp]=c100730037.UsedLP[tp]+1200
	Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730037,0))
	Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(100730037,0))
	local c=Duel.CreateToken(tp,65810489)
	Duel.SSet(tp,c)
end